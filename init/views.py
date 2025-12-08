from django.shortcuts import render

# Create your views here.
from django.contrib.auth.models import User
from .models import Material, In_storage, Out_storage
from django.shortcuts import render
from django.contrib.auth.views import LoginView, LogoutView
from .models import Backup_form
import os
from django.core.management import call_command
from django.contrib.admin.views.decorators import staff_member_required
from django.contrib import admin
from django.contrib import messages
from django.contrib.admin.views.decorators import staff_member_required
from django.core.management import call_command
from django.http import HttpResponse
from django.urls import path
from django.utils import timezone
import os
import datetime
from django.contrib import messages


from django.utils.safestring import mark_safe

def dashboard(request):
    """
    仪表盘视图函数，显示系统概览信息
    
    参数:
    - request: HTTP请求对象
    
    返回:
    - 渲染后的仪表盘页面
    """
    # 获取所有物料
    materials = Material.objects.all() 
    # 初始化最小库存警告
    min_warning = '' 
    # 初始化最大库存警告
    max_warning = '' 
    # 遍历所有物料
    for material in materials:
        # 如果库存小于最小库存,则警告
        if material.Now_inventory < material.Min_inventory:
            min_warning=f'{material}库存不足,请及时补货'  
        elif material.Now_inventory > material.Max_inventory:
            max_warning=f'{material}库存超出,不允许进货' 
    
    # 统计物料总数
    inventory_count = Material.objects.count()
    # 获取当前用户
    user = request.user
    # 判断用户角色
    firstname2 = '超级管理员' if user.is_superuser else '普通用户'
    # 构造上下文数据
    context = {
        'inventory_count': inventory_count, 
        'username': user.username, 
        'firstname2': firstname2, 
        'min_warning':min_warning, 
        'max_warning':max_warning
    }
    # 返回dashboard.html页面
    return render(request, 'dashboard.html', context)
 

def is403_view(request, exception):
    """
    403错误页面视图函数
    
    参数:
    - request: HTTP请求对象
    - exception: 异常对象
    
    返回:
    - 渲染后的403错误页面
    """
    return render(request, '403.html', status=403)


def safeguard(request):
    """
    数据备份视图函数
    
    参数:
    - request: HTTP请求对象
    
    返回:
    - 渲染后的数据备份页面
    """
    # 只处理POST请求
    if request.method == 'POST':
        # 获取操作类型
        action=request.POST.get('action')
        # 如果是备份操作
        if action=='backup':
            # 获取当前登录用户
            adminstrator=request.user
            # 获取当前备份数
            B_number=Backup_form.objects.all().count()+1 
            # 获取当前时间
            current_time=datetime.datetime.now() 
            # 构造备份文件名
            backup_filename = f'backup_{current_time.strftime("%Y%m%d%H%M%S")}_{adminstrator}_{B_number}.json'
            # 构造备份文件路径
            backup_path = os.path.join('backup', backup_filename)
            # 执行数据备份命令
            call_command('dumpdata', exclude=['auth.permission', 'contenttypes', 'init.Backup_form'],output=backup_path)    
            # 弹窗提示备份成功
            messages.success(request, '备份成功')
            # 生成备份记录
            Backup_form.objects.create(B_number=B_number, B_date=current_time, B_administrator=adminstrator, B_file=backup_filename)
    # 返回数据备份页面
    return render(request, 'safeguard.html')

from django.db.models.functions import Cast
from django.db.models import DateField
import xlwt
from django.http import HttpResponse
import datetime
from django.contrib.auth.decorators import login_required

@login_required
def index(request):
    """
    首页视图函数，需要登录才能访问
    
    参数:
    - request: HTTP请求对象
    
    返回:
    - 渲染后的首页页面
    """
    # 获取用户名
    username=request.user.username
    # 获取用户权限
    permissions=request.user.get_all_permissions()
    # 返回首页页面
    return render(request, 'index.html',context=  {'username': username,'permissions':permissions})

def monthly_report(request):
    """
    月度报表视图函数
    
    参数:
    - request: HTTP请求对象
    
    返回:
    - 渲染后的月度报表页面或者Excel文件
    """
    # 获取当前月份和年份
    month = datetime.datetime.now().month
    year = datetime.datetime.now().year
    
    # 处理POST请求
    if request.method == 'POST':
        action=request.POST.get('action')
        # 搜索操作
        if action=='search':
            month=int(request.POST.get('month'))
            year=int(request.POST.get('year'))
    
    # 查询数据库以获取所有相关数据
    materials = Material.objects.annotate(now_date=Cast('Now_datetime', output_field=DateField())) \
                           .filter(now_date__year=year, now_date__month=month)
    in_storage = In_storage.objects.annotate(in_date=Cast('In_date', output_field=DateField())) \
                            .filter(in_date__year=year, in_date__month=month)
    # in_storage = In_storage.objects.filter(Mnumber__in=materials)
    # out_storage = Out_storage.objects.filter(Mnumber__in=materials)

    out_storage = Out_storage.objects.annotate(out_date=Cast('Out_date', output_field=DateField())) \
                                .filter(out_date__year=year, out_date__month=month)
                                
    # 将数据传递给模板进行渲染
    context = {
        'materials': materials,
        'in_storages': in_storage,
        'out_storage': out_storage,
        'year': year,
        'month': month,
    }
    
    # 处理POST请求
    if request.method == 'POST':
        action=request.POST.get('action')
        # 导出操作
        if action=='export':
            return _extracted_from_monthly_report_21(materials, in_storage, out_storage,year,month)
    # 返回月度报表页面
    return render(request, 'month.html', context)



import os
def _extracted_from_monthly_report_21(materials, in_storage, out_storage,year,month):
    """
    月度报表导出功能，生成Excel文件
    
    参数:
    - materials: 物料数据查询集
    - in_storage: 入库数据查询集
    - out_storage: 出库数据查询集
    - year: 年份
    - month: 月份
    
    返回:
    - 包含Excel文件的HTTP响应对象
    """
    # 指定返回格式为excel，excel文件MINETYPE为application/vnd.ms-excel
    response = HttpResponse(content_type='application/vnd.ms-excel') 
    # 指定返回文件名为月度报表
    response['Content-Disposition'] = f'attachment;filename={year}-{month}-monthlyreport.xls' 
    # 创建一个工作簿
    wb = xlwt.Workbook(encoding='utf-8') 
    # 创建三个工作表
    sheet1 = wb.add_sheet('物料库存')
    sheet2 = wb.add_sheet('入库记录')
    sheet3 = wb.add_sheet('出库记录')

    # 创建一个居中对齐的样式
    style = xlwt.XFStyle()
    alignment = xlwt.Alignment()
    alignment.horz = xlwt.Alignment.HORZ_CENTER
    style.alignment = alignment
    font=xlwt.Font()
    font.name='宋体'
    font.bold=True
    font.height=20*11 #设置字体大小
    style.font=font

    # 将样式应用于单元格
    sheet1.write_merge(0, 0, 0, 8, '物料库存', style)
    sheet1.write(1, 0, '物料序号', style)
    sheet1.write(1, 1, '物料名字', style)
    sheet1.write(1, 2, '物料价格', style)
    sheet1.write(1, 3, '最大库存', style)
    sheet1.write(1, 4, '最小库存', style)
    sheet1.write(1, 5, '当前库存', style)
    sheet1.write(1, 6, '物料描述', style)
    sheet1.write(1, 7, '物料时间', style)
    sheet1.write(1, 8, '供应商', style)
    data_row = 2
    sheet2.write_merge(0, 0, 0, 5, '入库记录', style)
    sheet2.write(1, 0, '入库编号', style)
    sheet2.write(1, 1, '物料序号', style)
    sheet2.write(1, 2, '入库来源', style)
    sheet2.write(1, 3, '入库时间', style)
    sheet2.write(1, 4, '入库供应商', style)
    sheet2.write(1, 5, '入库库存', style)
    sheet3.write_merge(0, 0, 0, 5, '出库记录', style)
    sheet3.write(1, 0, '出库编号', style)
    sheet3.write(1, 1, '物料序号', style)
    sheet3.write(1, 2, '出库方式', style)
    sheet3.write(1, 3, '出库时间', style)
    sheet3.write(1, 4, '出库供应商', style)
    sheet3.write(1, 5, '出库库存', style)
    
    # 写入物料数据
    for obj in materials:
        # 创建一个居中对齐的样式
        style = xlwt.XFStyle()
        alignment = xlwt.Alignment()
        alignment.horz = xlwt.Alignment.HORZ_CENTER
        style.alignment = alignment
        sheet1.write(data_row, 0, obj.Mnumber, style)
        sheet1.write(data_row, 1, str(obj.Mname), style)
        sheet1.write(data_row, 2, obj.Price, style)
        sheet1.write(data_row, 3, obj.Max_inventory, style)
        sheet1.write(data_row, 4, obj.Min_inventory, style)
        sheet1.write(data_row, 5, obj.Now_inventory, style)
        sheet1.write(data_row, 6, obj.Description, style)
        sheet1.write(data_row, 7, str(obj.Now_datetime), style)
        sheet1.write(data_row, 8, obj.Supplier, style)   
        data_row = data_row + 1

    # 写入入库数据
    data_row = 2
    for obj in in_storage:
        # 创建一个居中对齐的样式
        style = xlwt.XFStyle()
        alignment = xlwt.Alignment()
        alignment.horz = xlwt.Alignment.HORZ_CENTER
        style.alignment = alignment
        sheet2.write(data_row, 0, obj.In_number, style)
        sheet2.write(data_row, 1, str(obj.Mnumber), style)
        sheet2.write(data_row, 2, obj.Source, style)
        sheet2.write(data_row, 3, str(obj.In_date), style)
        sheet2.write(data_row, 4, obj.In_supplier, style)
        sheet2.write(data_row, 5, obj.In_inventory, style)
        data_row = data_row + 1

    # 写入出库数据
    data_row = 2
    for obj in out_storage:
        # 创建一个居中对齐的样式
        style = xlwt.XFStyle()
        alignment = xlwt.Alignment()
        alignment.horz = xlwt.Alignment.HORZ_CENTER
        style.alignment = alignment
        sheet3.write(data_row, 0, obj.Out_number, style)
        sheet3.write(data_row, 1, str(obj.Mnumber), style)
        sheet3.write(data_row, 2, obj.Out_way, style)
        sheet3.write(data_row, 3, str(obj.Out_date), style)
        sheet3.write(data_row, 4, obj.Out_supplier, style)
        sheet3.write(data_row, 5, obj.Out_inventory, style)
        data_row = data_row + 1
        
    # 保存Excel文件并返回响应
    wb.save(response)
    return response

from django.contrib.auth.forms import UserCreationForm
from django.shortcuts import render, redirect
from django.contrib.auth.models import Group
from django.contrib.auth.models import Permission
from .models import In_storage, Out_storage, Material,Check_sheet,Backup_form
from django.contrib.auth.models import Group, Permission


view_check_sheet = Permission.objects.get(codename='view_check_sheet')
add_in_storage = Permission.objects.get(codename='add_in_storage')
view_in_storage = Permission.objects.get(codename='view_in_storage')
add_material = Permission.objects.get(codename='add_material')
view_material = Permission.objects.get(codename='view_material')
add_out_storage = Permission.objects.get(codename='add_out_storage')
view_out_storage = Permission.objects.get(codename='view_out_storage')
# 获取名为norml_group1的分组
group = Group.objects.get(name='norml_group1')
# 将view_material和view_article权限授予norml_group1分组
group.permissions.add(add_in_storage, view_in_storage, add_material, view_material, add_out_storage, view_out_storage)

def register(request):
    """
    用户注册视图函数
    
    参数:
    - request: HTTP请求对象
    
    返回:
    - 渲染后的注册页面或者重定向到管理后台
    """
    # 处理POST请求
    if request.method == 'POST':
        # 获取所有权限
        permissions = Permission.objects.all()

        # 打印所有权限的名称和代码名
        for permission in permissions:
            print(f'{permission.name}: {permission.codename}')
        
        # 创建表单对象
        form = UserCreationForm(request.POST) 
        # 判断表单数据是否合法
        if form.is_valid(): 
            # 将表单数据保存到数据库
            form.save() 
            # 设置为is_staff=True，允许登录admin后台
            user = User.objects.get(username=form.cleaned_data['username'])
            user.is_staff = True
            # 将用户添加到norml_group1分组
            user.groups.add(group)
            user.save()
            # 显示注册成功的消息
            messages.success(request, '注册成功！')
            # 跳转到管理后台首页
            return redirect('admin:index') 
        else:
            # 如果数据不合法，返回具体的错误信息
            errors = form.errors.as_data()
            for field, errors in errors.items():
                for error in errors:
                    message = f"{field}: {error.message}"
                    # 使用JavaScript的alert()函数显示错误信息
                    return HttpResponse(f"<script>alert('{message}');window.history.back();</script>")
            print(form.errors)
    else:
        # GET请求，创建空表单对象
        form = UserCreationForm() 
    # 返回注册页面
    return render(request, 'register.html', {'form': form})
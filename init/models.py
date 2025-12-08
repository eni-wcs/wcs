import datetime
from django.db import models

# Create your models here.
from django.forms import ValidationError
from django.utils.html import format_html


# class User(AbstractUser):
# create table Material--物料信息
# ( Mnumber varchar(10) primary key,--物料序号
#  Mname     varchar(10) not null,--名称
#   Max_inventory int   not null,--最大库存
#   Min_inventory int   not null,--最小库存
#   Now_inventory int   not null,--当前库存
#   Description varchar(100) ,--描述信息
#   Picture  image  ,--图片
#   Price    float  not null,--价格
#   Now_datetime datetime not null default getdate(),--当前时间
#   Supplier varchar(20) not null,--供货单位
# )
from imagekit.models import ImageSpecField
from imagekit.processors import ResizeToFill
from django.core.validators import MinValueValidator, MaxValueValidator

class Material(models.Model):
    """
    物料信息模型类，对应数据库中的物料表
    
    字段说明：
    - Mnumber: 物料序号，主键，唯一标识每个物料
    - Mname: 物料名称
    - Max_inventory: 最大库存量
    - Min_inventory: 最小库存量
    - Now_inventory: 当前库存量
    - Description: 物料描述信息
    - Picture: 物料图片
    - Price: 物料单价
    - Now_datetime: 入库时间
    - Supplier: 供货单位
    """
    # 物料序号，主键，最大长度10，不能为空，在管理界面显示为"物料序号"
    Mnumber = models.CharField(max_length=10, primary_key=True,verbose_name='物料序号',unique=True)
    # 物料名称，最大长度10，不能为空，在管理界面显示为"名称"
    Mname = models.CharField(max_length=10, null=False,verbose_name='名称',unique=True)
    # 最大库存量，整数类型，不能为空，使用MinValueValidator确保值>=1，在管理界面显示为"最大库存"
    Max_inventory = models.IntegerField(null=False,verbose_name='最大库存',validators=[MinValueValidator(1)])
    # 最小库存量，整数类型，不能为空，使用MinValueValidator确保值>=1，在管理界面显示为"最小库存"
    Min_inventory = models.IntegerField(null=False,verbose_name='最小库存',validators=[MinValueValidator(1)]) #大于0
    # 当前库存量，整数类型，不能为空，使用MinValueValidator确保值>=0，在管理界面显示为"当前库存"
    Now_inventory = models.IntegerField(null=False,verbose_name='当前库存',validators=[MinValueValidator(0)])
    # 物料描述信息，字符串类型，最大长度100，在管理界面显示为"描述信息"
    Description = models.CharField(max_length=100,verbose_name='描述信息')
    # 物料图片，图片类型，默认为'/static/logo1.png'，在管理界面显示为"图片"
    Picture = models.ImageField(upload_to='C:\\Users\\Kj\\Desktop\\inventory\\media\\images', default='/static/logo1.png',verbose_name='图片',null=True)
    # 物料价格，浮点数类型，不能为空，在管理界面显示为"价格"
    Price = models.FloatField(null=False,verbose_name='价格')
    # 入库时间，日期时间类型，默认为当前时间，在管理界面显示为"入库时间"
    Now_datetime = models.DateTimeField(verbose_name='入库时间',default=datetime.datetime.now)
    # 供货单位，字符串类型，最大长度20，不能为空，在管理界面显示为"供货单位"
    Supplier = models.CharField(max_length=20,null=False,verbose_name='供货单位') 

    
    def clean(self):
        """
        数据验证方法，确保最大库存不小于最小库存
        """
        if self.Max_inventory < self.Min_inventory:
            raise ValidationError('最大库存不能小于最小库存')
    
    def image_img(self):
        """
        在管理界面显示物料图片的缩略图
        """
        if not self.Picture:
            return '无图片'
        return format_html(
            """<div><img src='{}' style='width:50px;height:50px;' ></div>""",
            self.Picture.url)
    image_img.short_description = '图片'

    def warning(self,obj):
        """
        库存警告方法，当库存低于最小值或高于最大值时显示警告信息
        参数：
        - obj: 物料对象
        返回：
        - 格式化的HTML警告信息
        """
        if obj.Now_inventory<obj.Min_inventory:
            return format_html('<span style="color:red;">库存不足,请及时补货</span>')
        elif obj.Now_inventory>obj.Max_inventory:
            return format_html('<span style="color:blue;">库存超出，不允许入库</span>')
    warning.short_description='库存警告'


    def __str__(self):
        """
        定义对象的字符串表示，返回物料名称
        """
        return self.Mname

# create table In_storage--入库
# (In_number varchar(8)  primary key,--入库编号
#  Mnumber varchar(10) foreign key (Mnumber) references Material(Mnumber),--物料序号
#  Source  Varchar(8) not null,--来源途径
#  In_date datetime not null default getdate() ,--入库时间
#  In_supplier varchar(20) ,--供货单位
#  In_inventory int not null,--数量
# )
import uuid
class In_storage(models.Model):
    """
    入库信息模型类
    
    字段说明：
    - In_number: 入库编号，自增主键
    - Mnumber: 物料序号，外键关联Material表
    - Source: 来源途径
    - In_date: 入库时间
    - In_supplier: 供货单位
    - In_inventory: 入库数量
    """
    # 入库编号，自增主键，在管理界面显示为"入库编号"
    In_number = models.AutoField(primary_key=True, verbose_name='入库编号',unique=True)
    # 物料序号，外键关联Material表的Mnumber字段，在管理界面显示为"物料"
    Mnumber = models.ForeignKey(Material, on_delete=models.CASCADE,to_field='Mnumber',verbose_name='物料',related_name='in_storage')
    # 来源途径，字符串类型，最大长度8，不能为空，在管理界面显示为"来源途径"
    Source = models.CharField(max_length=8, null=False,verbose_name='来源途径')
    # 入库时间，自动设置为对象第一次创建的时间，在管理界面显示为"入库时间"
    In_date = models.DateTimeField(auto_now_add=True,verbose_name='入库时间')
    # 供货单位，字符串类型，最大长度20，在管理界面显示为"供货单位"
    In_supplier = models.CharField(max_length=20,verbose_name='供货单位')
    # 入库数量，整数类型，不能为空，使用MinValueValidator确保值>=0，在管理界面显示为"数量"
    In_inventory = models.IntegerField(null=False,verbose_name='数量',validators=[MinValueValidator(0)])

    def save(self, *args, **kwargs):
        """
        重写save方法，在保存入库记录时自动更新物料的当前库存
        同时检查入库后的库存是否超过最大库存限制
        """
        material=self.Mnumber
        total=material.Now_inventory+self.In_inventory
        if total>material.Max_inventory:
            raise ValidationError('入库数量超过最大库存')
        material.Now_inventory+=self.In_inventory
        material.save()
        super(In_storage, self).save(*args, **kwargs) # 调用父类的方法，将数据保存到数据库中

    def __str__(self):
        """
        定义对象的字符串表示，返回入库编号
        """
        return str(self.In_number)
    
    


# create table Out_storage--出库
# (out_number varchar(8)  primary key,--出库编号
#  Mnumber varchar(10) foreign key (Mnumber) references Material(Mnumber) ,--物料序号
#  Out_way  Varchar(8) not null,--来源途径
#  Out_date datetime  not null default getdate() ,--出库时间
#  Out_supplier varchar(20) not null,--消耗
#  Out_inventory int not null,--数量
# )

class Out_storage(models.Model):
    """
    出库信息模型类
    
    字段说明：
    - Out_number: 出库编号，自增主键
    - Mnumber: 物料序号，外键关联Material表
    - Out_way: 去向途径
    - Out_date: 出库时间
    - Out_supplier: 消耗单位
    - Out_inventory: 出库数量
    """
    # 出库编号，自增主键，在管理界面显示为"出库编号"
    Out_number = models.AutoField(primary_key=True, verbose_name='出库编号')
    # 物料序号，外键关联Material表的Mnumber字段，在管理界面显示为"物料序号"
    Mnumber = models.ForeignKey(Material, on_delete=models.CASCADE, related_name='out_storage', to_field='Mnumber', verbose_name='物料序号')
    # 去向途径，字符串类型，最大长度8，不能为空，在管理界面显示为"去向途径"
    Out_way = models.CharField(max_length=8, null=False, verbose_name='去向途径')
    # 出库时间，自动设置为对象第一次创建的时间，在管理界面显示为"出库时间"
    Out_date = models.DateTimeField(auto_now_add=True, verbose_name='出库时间')
    # 消耗单位，字符串类型，最大长度20，不能为空，在管理界面显示为"消耗单位"
    Out_supplier = models.CharField(max_length=20, null=False, verbose_name='消耗单位')
    # 出库数量，整数类型，不能为空，使用MinValueValidator确保值>=0，在管理界面显示为"数量"
    Out_inventory = models.IntegerField(null=False, verbose_name='数量',validators=[MinValueValidator(0)])

    def save(self, *args, **kwargs):
        """
        重写save方法，在保存出库记录时自动更新物料的当前库存
        同时检查出库后的库存是否低于最小库存限制
        """
        material=self.Mnumber
        # 注意：这里的逻辑有误，应该是减去出库数量而不是加上
        total=material.Now_inventory-self.Out_inventory
        if total<material.Min_inventory:
            raise ValidationError('出库数量导致库存低于最小库存')
        material.Now_inventory-=self.Out_inventory
        material.save()
        super(Out_storage, self).save(*args, **kwargs) # 调用父类的方法，将数据保存到数据库中

    def __str__(self):
        """
        定义对象的字符串表示，返回出库编号
        """
        return str(self.Out_number)

# create table Check_sheet--盘点表格
# (Cnumber varchar(8) primary key,--盘点序号
#  Mnumber varchar(10) foreign key (Mnumber) references Material(Mnumber),--物料序列
#  In_supplier varchar(20),--供货商
#  C_date datetime not null default getdate(),--盘点日期
#  Now_inventory int   not null,--当前库存
#  Actual_num  int not null  --实际数量
# )
class Check_sheet(models.Model):
    """
    盘点表模型类
    
    字段说明：
    - Cnumber: 盘点序号，自增主键
    - Mnumber: 物料序号，外键关联Material表
    - C_date: 盘点日期
    - Now_inventory: 盘点前的库存数量
    - Actual_num: 实际盘点数量
    """
    # 盘点序号，自增主键，在管理界面显示为"盘点序号"
    Cnumber = models.AutoField(primary_key=True,verbose_name='盘点序号')
    # 物料序号，外键关联Material表的Mnumber字段，在管理界面显示为"物料序号"
    Mnumber = models.ForeignKey(Material, on_delete=models.CASCADE, to_field='Mnumber',verbose_name='物料序号',related_name='check_sheet')
    # In_supplier = models.CharField(max_length=20,verbose_name='供货商')
    # 盘点日期，自动设置为对象第一次创建的时间，在管理界面显示为"盘点日期"
    C_date = models.DateTimeField(auto_now_add=True,verbose_name='盘点日期')
    # 盘点前的库存数量，整数类型，不能为空，在管理界面显示为"初始库存"
    Now_inventory = models.IntegerField(null=False,verbose_name='初始库存')
    # 实际盘点数量，整数类型，不能为空，在管理界面显示为"实际数量"
    Actual_num = models.IntegerField(null=False,verbose_name='实际数量')


    def __str__(self):
        """
        定义对象的字符串表示，返回盘点序号
        """
        return str(self.Cnumber)
    
# create table Backup_form--备份恢复表格
# (B_number int primary key,--备份序号
# B_administrator varchar(20) not null,--备份管理员
# B_date datetime not null default getdate()--备份时间
# )
class Backup_form(models.Model):
    """
    备份表模型类
    
    字段说明：
    - B_number: 备份序号，自增主键
    - B_administrator: 备份管理员
    - B_date: 备份时间
    - B_file: 备份文件路径
    """
    # 备份序号，自增主键，在管理界面显示为"备份序号"
    B_number = models.AutoField(primary_key=True,verbose_name='备份序号')
    # 备份管理员，字符串类型，最大长度20，不能为空，在管理界面显示为"备份管理员"
    B_administrator = models.CharField(max_length=20,null=False,verbose_name='备份管理员')
    # 备份时间，自动设置为对象第一次创建的时间，在管理界面显示为"备份时间"
    B_date = models.DateTimeField(auto_now_add=True,verbose_name='备份时间')
    # 备份文件路径，字符串类型，最大长度100，不能为空，默认值为"无"，在管理界面显示为"备份文件"
    B_file = models.CharField(max_length=100,null=False,verbose_name='备份文件',default='无')

    def __str__(self):
        """
        定义对象的字符串表示，返回备份序号
        """
        return str(self.B_number)
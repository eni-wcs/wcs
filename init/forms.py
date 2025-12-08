from django.contrib.auth.forms import UserCreationForm  # 导入系统内置的表单，用于继承
from django.contrib.auth.models import User  # 导入系统的user模型，此处因为我用的就是系统自带的
from django import forms  # 导入表单模块


class usercreation(UserCreationForm):
    """
    自定义用户创建表单，继承自Django内置的UserCreationForm
    
    新增字段：
    - email: 邮箱字段，可选
    - username: 用户名字段，必填
    """
    # 邮箱字段，非必填，在表单中显示为"邮箱"
    email = forms.EmailField(required=False, label='邮箱')  
    # 用户名字段，必填，在表单中显示为"用户名"
    username = forms.CharField(required=True, label='用户名')  

    class Meta:
        # 关联的模型为系统的User模型
        model = User
        # 表单字段顺序
        fields = ('username', 'password1', 'password2', 'is_superuser')  
        # 设置错误信息提示
        error_messages = {  
            'username': {
                'required': '用户名不能为空',
                'max_length': '用户名最长不超过150个字符',
                'unique': '用户名已存在',
            },
        }
        # 设置帮助文本
        help_texts = {
            'username': '用户名最长不超过150个字符a',
        }
        # 设置字段标签
        labels = {
            'username': '用户名',
        }
        # 设置字段的小部件样式
        widgets = {
            'username': forms.TextInput(attrs={'class': 'form-control', 'placeholder': '请输入用户名a'}),
        }
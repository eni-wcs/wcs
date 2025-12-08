#!/usr/bin/env python
"""Django's command-line utility for administrative tasks."""
import os
import sys


def main():
    """
    主函数，用于运行Django管理命令
    
    设置默认的Django配置模块，然后执行命令行参数指定的命令
    """
    # 设置默认的Django配置模块为inventory.settings
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'inventory.settings')
    try:
        # 从django.core.management导入execute_from_command_line函数
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        # 如果导入失败，抛出ImportError异常并给出详细提示
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and "
            "available on your PYTHONPATH environment variable? Did you "
            "forget to activate a virtual environment?"
        ) from exc
    # 执行命令行参数指定的命令
    execute_from_command_line(sys.argv)


if __name__ == '__main__':
    # 当脚本被直接运行时，调用main函数
    main()
from django.contrib import admin
from django.urls import path
from . import views
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('admin/', admin.site.urls,name='admin'),
    path('tasks/dashboard/', views.dashboard, name='dashboard'),
    path('safeguards/', views.safeguard, name='safeguard'),
    path('month/',views.monthly_report,name='month'),
    path('register/', views.register, name='register'),
    path('',views.register,name='register'),
    path('index/',views.index,name='index'),
]
# 开发环境下提供媒体文件访问支持
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

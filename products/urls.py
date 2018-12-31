from django.urls import path
from django.shortcuts import render, redirect

from . import views

app_name = 'products'
urlpatterns = [
    path('', views.index, name='index'),
    path('<int:pk>', views.detail, name='detail'),
]

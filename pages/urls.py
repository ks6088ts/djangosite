from django.urls import path
from django.shortcuts import render, redirect

from . import views

app_name = 'pages'
urlpatterns = [
    path('', views.index, name='index'),
    path('contact', views.contact, name='contact'),
]

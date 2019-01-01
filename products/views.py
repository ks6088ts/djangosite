from django.views import generic
from django.shortcuts import render
from django.shortcuts import get_object_or_404

from .models import Product, Category

class ListView(generic.ListView):
    template_name = 'products/index.html'
    context_object_name = 'product_list'
    # paginate_by = 5
    ordering = '-pk'

    def get_queryset(self):
        return Product.objects.all()

index = ListView.as_view()

class DetailView(generic.DetailView):
    model = Product
    template_name = 'products/detail.html'

    def get_queryset(self):
        return Product.objects.all()

detail = DetailView.as_view()


class CategoryView(generic.ListView):
    template_name = 'products/index.html'
    context_object_name = 'product_list'
    # paginate_by = 5
    ordering = '-pk'

    def get_queryset(self):
        self.category = get_object_or_404(Category, category_text=self.kwargs["pk"])
        return Product.objects.filter(category=self.category)

category = CategoryView.as_view()

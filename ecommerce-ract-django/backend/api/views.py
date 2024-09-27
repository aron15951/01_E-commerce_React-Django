from rest_framework.decorators import api_view
from rest_framework.response import Response
from .models import Product, Category
from .serializers import CategorySerializer, ProductSerializer
from django.shortcuts import render, redirect
from .forms import CategoryForm, ProductForm

@api_view(['GET'])  # Especificamos que este endpoint solo acepta solicitudes GET
def product_list(request):
    products = Product.objects.all()
    serializer = ProductSerializer(products, many=True)
    return Response(serializer.data)

@api_view(['GET'])  # Especificamos que este endpoint solo acepta solicitudes GET
def category_list(request):
    categories = Category.objects.all()
    serializer = CategorySerializer(categories, many=True)
    return Response(serializer.data)

def add_category(request):
    if request.method == 'POST':
        form = CategoryForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('category_list')
    else:
        form = CategoryForm()
    return render(request, 'store/add_category.html', {'form': form})

def add_product(request):
    if request.method == 'POST':
        form = ProductForm(request.POST, request.FILES)
        if form.is_valid():
            form.save()
            return redirect('product_list')
    else:
        form = ProductForm()
    return render(request, 'store/add_product.html', {'form': form})  



import { useEffect, useState } from "react";
import axios from 'axios';
const ProductList = () => {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    axios.get('http://127.0.0.1:8000/api/products/').then(response => setProducts(response.data)).catch(error => console.error(error));
  }, [])

  return (
    <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
      {products.map(product => (
        <div key={product.id} className="border p-4 rounded-lg">
          <img 
    src={product.image} 
    alt={product.name} 
    className="h-full w-full object-cover object-center"
    onError={(e) => {
      e.target.onerror = null;
      e.target.src = '/path/to/default-image.jpg'; // Imagen por defecto
    }}
  />
          <h2 className="mt-2 text-lg">{product.name}</h2>
          <h2>{product.description  }</h2>
          <p className="text-gray-600">{product.price}</p>
        </div>
      ))}

    </div>
  )
}

export default ProductList;

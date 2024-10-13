// Atualizar o total quando a quantidade muda
const quantities = document.querySelectorAll('.quantity');
const totalElement = document.getElementById('total');

quantities.forEach(quantity => {
    quantity.addEventListener('change', updateTotal);
});

function updateTotal() {
    let total = 0;
    quantities.forEach(quantity => {
        const itemPrice = parseFloat(quantity.closest('.cart-item').querySelector('p').textContent.replace('Preço: R$', ''));
        const itemQuantity = parseInt(quantity.value);
        total += itemPrice * itemQuantity;
    });
    totalElement.textContent = total.toFixed(2);
}

// Remover item do carrinho
const removeButtons = document.querySelectorAll('.remove-item');

removeButtons.forEach(button => {
    button.addEventListener('click', function() {
        this.closest('.cart-item').remove();
        updateTotal();
    });
});
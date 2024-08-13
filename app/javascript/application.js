// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "jquery"
import "bootstrap"
import "@nathanvda/cocoon"

document.addEventListener('DOMContentLoaded', () => {
  console.log("Document loaded and Cocoon initialized");

  // Verificar se o jQuery está carregado
  if (typeof $ !== 'undefined') {
    console.log("jQuery is loaded");
  } else {
    console.log("jQuery is not loaded");
  }

  // Adicionar um event listener para verificar se o clique está sendo capturado
  document.querySelectorAll('.add_fields').forEach(element => {
    element.addEventListener('click', function(event) {
      event.preventDefault();
      console.log("Add fields clicked");
    });
  });
});
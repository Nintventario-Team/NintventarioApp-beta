Feature: Inventory Management
  Scenario: Navigate through Sale Spots, Home, and Inventory Creation with stock update
    Given I am on the "SaleSptosPage"
    Then I should see the text "Hola! \nAndrés Cornejo"
    And I should see a "GridView"
    When I tap on the sale spot "Ceibos"
    Then I should be on the "Home" screen
    When I tap on the "Crear Inventario" button
    Then I should see the "Lista de productos" text
    When I select the "Todos" filter
    And I tap on the product "(Ps5)Fifa 23"
    Then I should see the "Detalles del producto" screen
    When I change the stock to "2"
    And I tap outside the TextField
    And I tap on the "Confirmar" button
    Then I should be back on the "Lista de productos" screen
    When I tap on "Detalles"
    Then I should be on the "Detalles del Inventario" screen
    When I change the inventory manager name to "Juan Pérez"
    And I tap outside the TextField
    And I tap on the "Guardar borrador" button
    Then I should see the "¡Borrador guardado exitosamente!" message

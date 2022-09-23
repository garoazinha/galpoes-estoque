require 'rails_helper'

describe 'Usuário vê detalhes de fornecedores' do
  it 'em página de detalhes' do
    #Arrange
    Supplier.create!(corp_name: 'Waystar Roy Group Inc', brand_name: 'Waystar Roy',
                      registration_id: '5647834521843', city: 'São Paulo', state: 'SP',
                      full_address: 'Rodovia do Cacau, 300', email:'contato@nestinc.com')
    #Act
    visit root_path
    #Assert
    
    
  end
end
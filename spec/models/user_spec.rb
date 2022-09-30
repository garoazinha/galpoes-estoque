require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'valido?' do
    it 'falso se e-mail não for em formato correto' do
      #Arrange
      usuario = User.create(name: 'Mari', email: 'marimaricom', password: '123456')
      #Act
      resultado = usuario.valid?
      #Assert
      expect(resultado).to be_falsy
    end
    it 'falso se senha tiver menos de 6 caracteres' do
      #Arrange
      usuario = User.create(name: 'Mari', email: 'mari@email.com', password: '1234')
      #Act
      resultado = usuario.valid?
      #Assert
      expect(resultado).to be_falsy
    end
  end

  describe 'description' do
    it 'exibe o nome e o e-mail' do
      #Arrange
      u = User.new(name: 'Pedro Tiago', email: 'pti@email.com')
      #Act
      result = u.description()
      #Assert
      expect(result).to eq("Pedro Tiago - pti@email.com")
      
    end
  end
  
end

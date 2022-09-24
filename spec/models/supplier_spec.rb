require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe 'válido?' do
    context 'para presença' do
      it 'falso quando não há razão social' do
        #Arrange
        s = Supplier.new(corp_name: '', brand_name: 'Waystar Roy',
                      registration_id: '56478345218439', city: 'São Paulo', state: 'SP',
                      full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                      phone: '3290906463')
        #Act
        resultado = s.valid?
        #Assert
        expect(resultado).to be_falsy
        
      end
      it 'falso quando não há nome fantasia' do
        #Arrange
        s = Supplier.new(corp_name: 'Waystar Royco Group INC', brand_name: '',
                      registration_id: '56478345218439', city: 'São Paulo', state: 'SP',
                      full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                      phone: '3290906463')
        #Act
        resultado = s.valid?
        #Assert
        expect(resultado).to be_falsy
        
      end
      it 'falso quando não há CNPJ' do
        #Arrange
        s = Supplier.new(corp_name: 'Waystar Royco Group INC', brand_name: 'Waystar Royco',
                      registration_id: '', city: 'São Paulo', state: 'SP',
                      full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                      phone: '3290906463')
        #Act
        resultado = s.valid?
        #Assert
        expect(resultado).to be_falsy
        
      end
      it 'falso quando não há e-mail' do
        #Arrange
        s = Supplier.new(corp_name: 'Waystar Royco Group INC', brand_name: 'Waystar Royco',
                      registration_id: '12345678901234', city: 'São Paulo', state: 'SP',
                      full_address: 'Rodovia do Cacau, 300', email:'',
                      phone: '3290906463')
        #Act
        resultado = s.valid?
        #Assert
        expect(resultado).to be_falsy
        
      end
    end
    context 'para unicidade' do
      it 'falso quando CNPJ é duplicado' do
        #Arrange
        fs = Supplier.create(corp_name: 'Waystar Royco Group INC', brand_name: 'Waystar Royco',
                              registration_id: '12345678901234', city: 'São Paulo', state: 'SP',
                              full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                              phone: '3290906463')
        ss = Supplier.new(corp_name: 'Lannister LTDA', brand_name: 'Lann',
                          registration_id: '12345678901234', city: 'Ribeirão Preto', state: 'SP',
                          full_address: 'Rodovia do chá, 322', email:'lann@lann.com',
                          phone: '3298989032')
        #Act
        resultado = ss.valid?
        #Assert
        expect(resultado).to be_falsy

      end

    end
    context 'para formato' do
      it 'cnpj tem menos de 14 digitos' do
        #Arrange
        s = Supplier.new(corp_name: 'Waystar Royco Group INC', brand_name: 'Waystar Roy',
                      registration_id: '564', city: 'São Paulo', state: 'SP',
                      full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                      phone: '3290906463')
        #Act
        resultado = s.valid?
        #Assert
        expect(resultado).to be_falsy
        
      end
      it 'cnpj tem mais de 14 digitos' do
        #Arrange
        s = Supplier.new(corp_name: 'Waystar Royco Group INC', brand_name: 'Waystar Roy',
                      registration_id: '1234567890123411', city: 'São Paulo', state: 'SP',
                      full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                      phone: '3290906463')
        #Act
        resultado = s.valid?
        #Assert
        expect(resultado).to be_falsy
        
      end
      it 'cnpj tem letras' do
        #Arrange
        s = Supplier.new(corp_name: 'Waystar Royco Group INC', brand_name: 'Waystar Roy',
                      registration_id: 'cd3456789012ab', city: 'São Paulo', state: 'SP',
                      full_address: 'Rodovia do Cacau, 300', email:'contato@waystar.com',
                      phone: '3290906463')
        #Act
        resultado = s.valid?
        #Assert
        expect(resultado).to be_falsy
        
      end
    end
  end
end

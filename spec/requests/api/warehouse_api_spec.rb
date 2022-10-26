require 'rails_helper'

describe "Warehouse API" do
  context "GET /api/v1/warehouses/1" do

    it "success" do
      warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
        area: 100_000, useful_area: 80_000,
        address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
        description: 'Galpão destinado para cargas internacionais')

      get "/api/v1/warehouses/#{warehouse.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eq('Aeroporto SP')
      expect(json_response["code"]).to eq('GRU')
      expect(json_response.keys).not_to include('created_at')
      expect(json_response.keys).not_to include('updated_at')
      
    end

    it 'fail if warehouse not found' do

      get "/api/v1/warehouses/99999"

      expect(response.status).to eq 404
      
    end
    
  end

  context "GET /api/v1/warehouses" do
    it 'success and ordered by name' do
      warehouse = Warehouse.create!(name: 'Galpão do Mar', code: 'RIO',
        city: 'Niteroi', state: 'RJ',
        area: 60_000, useful_area: 40_000,
        address: 'Avenida do Atlantico, 999', cep: '18000000', 
        description: 'Galpão destinado para cargas marítimas')

      other_warehouse = Warehouse.create!(name: 'Aeroporto SP', code: 'GRU', city: 'Guarulhos', state: 'SP',
        area: 100_000, useful_area: 80_000,
        address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
        description: 'Galpão destinado para cargas internacionais')

      get '/api/v1/warehouses'

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)

      expect(json_response.length).to eq 2
      expect(json_response[0]["name"]).to eq("Aeroporto SP")
      expect(json_response[1]["name"]).to eq("Galpão do Mar")
      
      

      
    end

    it 'returns empty if theres no warehouse' do

      get '/api/v1/warehouses'

      expect(response.status).to eq 200
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response).to eq []
      
    end

    it 'raises internal error' do
      allow(Warehouse).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

      get '/api/v1/warehouses'

      expect(response).to have_http_status(500)
      
    end
  end

  context "post /api/v1/warehouses" do
    it 'success' do
      warehouse_params = { warehouse: { name: 'Aeroporto SP', code: 'GRU',
        city: 'Guarulhos', state: 'SP',
        area: 100_000, useful_area: 80_000,
        address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
        description: 'Galpão destinado para cargas internacionais' }}
      
      post '/api/v1/warehouses', params: warehouse_params

      expect(response).to have_http_status(201)
      expect(response.content_type).to include('application/json')
      json_response = JSON.parse(response.body)
      expect(json_response["name"]).to eq ("Aeroporto SP")
      expect(json_response["code"]).to eq ("GRU")
      expect(json_response["city"]).to eq ("Guarulhos")
      expect(json_response["state"]).to eq ("SP")
      expect(json_response["area"]).to eq (100_000)
      expect(json_response["useful_area"]).to eq (80_000)
      expect(json_response["address"]).to eq ("Avenida do Aeroporto, 1000")
      expect(json_response["cep"]).to eq ("15000000")
      expect(json_response["description"]).to eq ("Galpão destinado para cargas internacionais")
    end

    it 'fails if parameters not complete' do
      warehouse_params = { warehouse: { name: 'Aeroporto Curitiba', code: 'CWB'}}

      post '/api/v1/warehouses', params: warehouse_params

      expect(response).to have_http_status(412)
      expect(response.body).not_to include("Código não pode ficar em branco")
      expect(response.body).to include("Cidade não pode ficar em branco")
      expect(response.body).to include("Estado não pode ficar em branco")

    end

    it 'fails if internal error' do
      allow(Warehouse).to receive(:new).and_raise(ActiveRecord::ActiveRecordError)
      warehouse_params = { warehouse: { name: 'Aeroporto SP', code: 'GRU',
        city: 'Guarulhos', state: 'SP',
        area: 100_000, useful_area: 80_000,
        address: 'Avenida do Aeroporto, 1000', cep: '15000000', 
        description: 'Galpão destinado para cargas internacionais' }}

      post '/api/v1/warehouses', params: warehouse_params
      
      expect(response).to have_http_status(500)
    end
  end
end
#!/bin/env ruby
# encoding: utf-8

class ApiController < ApplicationController
  after_filter :set_access_control_headers

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end



  caches_action :index


  def index

    cep  = params[:cep]


    options = { :body =>  {:cepEntrada => cep, :tipoCep => '', :cepTemp => '', :metodo => 'buscarCep'} }

    request = HTTParty.post('http://m.correios.com.br/movel/buscaCepConfirma.do', options)

    html_data = Nokogiri::HTML(request.body)

    response = html_data.css('.respostadestaque')


    if response.any?
      localidade = response[2].content.split('/')



      logradouro = response[0].content.strip.gsub(/(\s-\saté\s)([0-9-\/]*)/, '')
      cidade = localidade[0].strip
      estado = localidade[1].strip


      dados = {:codigo_postal => cep, :logradouro => logradouro,  :bairro => response[1].content.strip, :cidade=> cidade, :estado => estado }

  else
    dados = {:codigo_postal => params[:cep]}
  end
  
  @cep = Cep.where(dados).first_or_create



      respond_to do |format|
        format.json { render :json=> @cep }
        format.xml { render :xml => @cep }
      end





  end
end

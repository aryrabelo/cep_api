class Cep < ActiveRecord::Base
  attr_accessible :bairro, :cidade, :codigo_postal, :estado, :logradouro
end

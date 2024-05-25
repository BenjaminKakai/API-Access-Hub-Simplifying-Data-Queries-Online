require 'net/http'
require 'json'

class DataController < ApplicationController
  before_action :authenticate_user!

  def fetch
    url = URI.parse('https://cat-fact.herokuapp.com/facts/')
    response = Net::HTTP.get_response(url)
    facts = JSON.parse(response.body)

    @facts = facts.map do |fact|
      {
        text: fact['text'],
        verified: fact['status']['verified'] ? 'True' : 'False',
        created_at: Time.parse(fact['createdAt']).strftime('%d-%m-%Y %H:%M:%S')
      }
    end
  end
end

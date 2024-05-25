require 'net/http'
require 'json'

class DataController < ApplicationController
  before_action :authenticate_user!

  def fetch
    begin
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
    rescue OpenSSL::SSL::SSLError => e
      # Log the error or display a user-friendly message
      Rails.logger.error("SSL Error: #{e.message}")
      flash[:alert] = 'An SSL error occurred while fetching data. Please try again later.'
      redirect_to root_path
    rescue StandardError => e
      # Handle other exceptions
      Rails.logger.error("Error: #{e.message}")
      flash[:alert] = 'An error occurred while fetching data. Please try again later.'
      redirect_to root_path
    end
  end
end

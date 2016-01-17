class Webhooks::HbController < ApplicationController
  protect_from_forgery except: :perform

  def perform
    user = User.where(hatebu_key: params[:key]).first
    raise if user.nil?
    user.update!(hatebu_name: params[:username]) if user.hatebu_name.blank?

    qiita_item_id = parse_qiita_item_id params[:url]

    if qiita_item_id.nil?
      render text: ''
    else
      qiita = ::Qiita::Client.new access_token: user.access_token
      case params[:status]
      when 'add', 'update'
        qiita.stock_item(qiita_item_id)
        render text: 'ok'
      when 'delete'
        qiita.unstock_item(qiita_item_id)
        render text: 'ok'
      else
        render text: ''
      end
    end
  end

  private
  def parse_qiita_item_id(url)
    regexp_qiita_item_id = %r{items/([a-f0-9]*)}
    uri = URI(url)
    uri.host == 'qiita.com' && uri.path =~ regexp_qiita_item_id ? $1 : nil
  end
end

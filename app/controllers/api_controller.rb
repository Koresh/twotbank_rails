class ApiController < ApplicationController

  def offices
    city_id = params[:city_id]
    offices = {
      "989"=> [{ title: "Новороссийский филиал",
          content: '<p><strong>353900, г. Новороссийск, ул. Советов, д. 7</strong></p><div class="phones">    <span class="lText"><p>Телефон:</p></span>    <span class="rText">        <p>8-800-100-94-34</p>    </span></div><div class="item">    <span class="lText"><p>Обслуживание физ.лиц:</p></span>    <span class="rText">        <p>пн.-сб. <strong>09:00-20:30</strong> (без перерыва)</p>        <p>вс. <strong>10:00-15:00</strong></p>    </span></div><div class="item">    <span class="lText"><p>Обслуживание юр.лиц:</p></span>    <span class="rText">        <p>пн.-пт. <strong>09:00-18:00</strong> (без перерыва)</p></span></div>',
          id: 267,
          lat: 44.723354,
          lng: 37.767438,
          title: "Новороссийский филиал",
          type: "office"}
      ],
    }
    json = { offices: offices[city_id], success:true}
    render json: json.to_json
  end
end

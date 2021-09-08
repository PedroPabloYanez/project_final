class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_payment, only: %i[ show edit update destroy ]
  
  # GET /payments or /payments.json
  def index
    @payments = Payment.all
    
  end

  def pago_exitoso
    if params[:status] == 'approved'
      @status = params[:status]
      @payment_id = params[:payment_id]
      @type = params[:payment_type]
      
      Payment.create(status: @status, payment_id: @payment_id, payment_type: @type, user_id: current_user.id) 
      redirect_to root_path, notice: "Pago exitoso"
    else
      redirect_to root_path, notice: "El pago no se pudo efectuar"
    end
  end

  def mercado_pago
    # # SDK de Mercado Pago
    require 'mercadopago'
    # # Agrega credenciales
    sdk = Mercadopago::SDK.new(ENV["MERCADO_PAGO_KEY"])
    
    # Crea un objeto de preferencia
    preference_data = {
      items: [
        {
          title: 'App Management',
          unit_price: 35000,
          description: 'Compra de software',
          quantity: 1
        }
      ],
      back_urls: {
        success: payments_success_url,
        failure: 'http://localhost:3000/payments',
        pending: 'http://localhost:3000/payments'
      },
      auto_return: 'approved'
      # ...
    }
    preference_response = sdk.preference.create(preference_data)
    preference = preference_response[:response]
    
    url_pay = preference["sandbox_init_point"]

    # Este valor reemplazará el string "<%= @preference_id %>" en tu HTML
    @preference_id = preference['id']
    redirect_to url_pay
  end
  #creamos credenciales
  #creamos metodo y ruta para el pago
  #construimos el preference(objeto que contiene la info del pago)
  #obtenemos el link de Pago
  #redireccionamos nuestro user a el link de pago a sandbox
  #añadimos los back urls
  #recibimos los parametros de regreos y los mostramos o guardamos

  # GET /payments/1 or /payments/1.json
  def show
  end

  def payment_failure

  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments or /payments.json
  def create
    @payment = Payment.new(payment_params)

    respond_to do |format|
      if @payment.save
        format.html { redirect_to @payment, notice: "Payment was successfully created." }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1 or /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: "Payment was successfully updated." }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1 or /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: "Payment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def payment_params
      params.require(:payment).permit(:status)
    end
end

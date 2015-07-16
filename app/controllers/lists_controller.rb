class ListsController < ApplicationController
  expose(:lists)
  expose(:list, attributes: :list_params)
  expose(:contacts)

  # GET /lists
  # GET /lists.json
  def index
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
  end

  # GET /lists/new
  def new
  end

  # GET /lists/1/edit
  def edit
  end

  # POST /lists
  # POST /lists.json
  def create
    respond_to do |format|
      if list.save
        format.html { redirect_to list_manage_contacts_path(list), notice: 'List was successfully created.' }
        format.json { render :show, status: :created, location: list }
      else
        format.html { render :new }
        format.json { render json: list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    respond_to do |format|
      if list.update(list_params)
        format.html { redirect_to list, notice: 'List was successfully updated.' }
        format.json { render :show, status: :ok, location: list }
      else
        format.html { render :edit }
        format.json { render json: list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url, notice: 'List was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def manage_contacts
    self.contacts = contacts - list.contacts
  end

  def add_contacts
    contacts = Contact.where(id: params[:contact_ids])
    list.contacts.push(contacts)
    redirect_to list
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def list_params
    params.require(:list).permit(:name)
  end
end

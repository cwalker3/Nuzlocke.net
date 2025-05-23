class TrainersController < ApplicationController
  before_action :set_area, only: %i[ new edit index update create ]
  before_action :set_trainer, only: %i[edit update]
  before_action :set_pokemon
  before_action :set_items
  before_action :set_moves
  before_action :set_abilities
  before_action :set_natures

  def new
    @trainer = Trainer.new
    @trainer.insert_at(params[:position].to_i)
    6.times do |i|
      @trainer.trainer_pokemon.build(position: i + 1)
    end
  end

  def create
    @trainer = Trainer.new(allowed_params)
    @trainer.insert_at(params[:trainer][:position].to_i)

    if @trainer.save
      redirect_to trainers_path(area_id: @trainer.area_id)
    else
        Rails.logger.debug @trainer.errors.full_messages.inspect
        raise ActiveRecord::RecordInvalid.new(@trainer)
      (6 - @trainer.trainer_pokemon.count).times { @trainer.trainer_pokemon.build }
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @trainers = @area.trainers
  end

  def edit
    (6 - @trainer.trainer_pokemon.count).times do |i|
      @trainer.trainer_pokemon.build(position: i + @trainer.trainer_pokemon.count + 1)
    end
  end

  def update
    @trainer.insert_at(params[:trainer][:position].to_i)
    if @trainer.update(allowed_params)
      redirect_to trainers_path(area_id: @trainer.area_id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_area
    if params[:area_id]
      @area = Area.find(params[:area_id])
    elsif params[:trainer] && params[:trainer][:area_id]
      @area = Area.find(params[:trainer][:area_id])
    end
  end 

  def set_trainer
    @trainer = Trainer.find(params[:id])
  end

  def set_pokemon
    @pokemon = Pokemon.all
  end

  def set_items
    @items = Item.all
  end

  def set_moves
    @moves = Move.all
  end

  def set_abilities
    @abilities = Ability.all
  end

  def set_natures
    @natures = Nature.all
  end

  def allowed_params
    params.require(:trainer).permit(
      :name, 
      :area_id,
      :position,
      trainer_pokemon_attributes: [
        :id,
        :pokemon_id,
        :level,
        :move1_id,
        :move2_id,
        :move3_id,
        :move4_id,
        :nature_id,
        :gender,
        :item_id,
        :ability_id,
        :position
      ])
  end
end

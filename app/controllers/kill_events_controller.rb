class KillEventsController < ApplicationController
  def create
    attempt_pokemon = AttemptPokemon.find(params[:kill_event][:attempt_pokemon_id])
    @attempt = attempt_pokemon.attempt
    trainer_pokemon = TrainerPokemon.find(params[:kill_event][:trainer_pokemon_id])
    @trainer = Trainer.find(trainer_pokemon.trainer.id)
    @kill_event = KillEvent.find_or_create_by(trainer_pokemon_id: params[:kill_event][:trainer_pokemon_id],
                                             attempt_id: @attempt.id)
    @kill_event.attempt_pokemon = attempt_pokemon
    if @kill_event.save
      respond_to do |format|
        format.turbo_stream
      end
    end
  end
end

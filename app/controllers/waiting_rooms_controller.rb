class WaitingRoomsController < ApplicationController

  def show

   @room = WaitingRoom.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end



  end

  def index
    @rooms = WaitingRoom.all

  end


  def new

    @waiting_room = WaitingRoom.new

  end

  def join
    room = WaitingRoom.find(params[:id])

   if  room.user >= room.users.count
    current_user.update_attribute(:waiting_room_id, room.id)
    redirect_to waiting_room_path(room.id)
   else
     flash[:notice] = (t 'index.error_join')
     redirect_to waiting_rooms_path

   end

  end

  def create

    room = WaitingRoom.new(params[:waiting_room])

    if room.save

      current_user.update_attribute(:waiting_room_id ,room.id)
      room.update_attribute(:owner_id, current_user.id)
      redirect_to  waiting_room_path(room.id)
    else

      flash[:notice] = (t 'new.error')
      redirect_to new_waiting_room_path

    end

  end

  def leave
    room = WaitingRoom.find(params[:id])
    if current_user.waiting_room_id == room.id

      current_user.update_attribute(:waiting_room_id, nil)
      flash[:notice] = (t 'show.leave_game_ok')

      if current_user.id == room.owner_id
        if room.users.empty?
          room.delete
          else
          room.update_attribute(:owner_id, room.users.first.id)
        end

      end

      redirect_to waiting_rooms_path
    else

      flash[:notice] = (t 'show.leave_game_error')

    end

  end

  def start
    room = WaitingRoom.find(params[:id])
    if room.user == room.users.count && room.owner_id == current_user.id
      game = Party.new(:numplayer => room.user, :name => room.name, :current_round => 0 )
      if game.save
        game.initialize_party(room.users)
        redirect_to party_path(game.id)
      end

    else
       redirect_to root_path
    end
  end
end

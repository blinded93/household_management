module RoomsHelper
  def room_errors
    'show d-block' unless @room.errors.empty?
  end
end

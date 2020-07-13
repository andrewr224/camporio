# frozen_string_literal: true

class BoardsController < ApplicationController
  include CableReady::Broadcaster

  before_action :set_board, only: [:show, :edit, :update, :destroy]

  def index
    @boards = Board.all.order(created_at: :desc)
    @board  = Board.new
  end

  def show; end

  def edit; end

  def create
    @board = Board.new(board_params)

    if @board.save
      cable_ready["timeline"].insert_adjacent_html(
        selector: "#timeline",
        position: "afterbegin",
        html:     render_to_string(partial: "board", locals: { board: @board })
      )

      cable_ready.broadcast

      redirect_to boards_path, notice: "Board was successfully created."
    else
      @boards = Board.all.order(created_at: :desc)

      render :index
    end
  end

  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to @board, notice: "Board was successfully updated." }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @board.destroy
    respond_to do |format|
      format.html { redirect_to boards_url, notice: "Board was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def board_params
    params.require(:board).permit(:name, :description)
  end
end

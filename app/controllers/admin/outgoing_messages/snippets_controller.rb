# Controller for managing OutgoingMessage::Snippet records
class Admin::OutgoingMessages::SnippetsController < AdminController
  include TranslatableParams

  before_action :set_snippet, only: %i[edit update]

  def index
    @title = 'Listing Snippets'
    @snippets = OutgoingMessage::Snippet.
      paginate(page: params[:page], per_page: 25)
  end

  def edit
    @title = 'Edit snippet'
    @snippet.build_all_translations
  end

  def update
    if @snippet.update(snippet_params)
      redirect_to admin_snippets_path, notice: 'Snippet successfully updated.'
    else
      @title = 'Edit snippet'
      @snippet.build_all_translations
      render action: :edit
    end
  end

  private

  def snippet_params
    translatable_params(
      params[:outgoing_message_snippet],
      translated_keys: [:locale, :name, :body],
      general_keys: [:tag_string]
    )
  end

  def set_snippet
    @snippet ||= OutgoingMessage::Snippet.find(params[:id])
  end
end

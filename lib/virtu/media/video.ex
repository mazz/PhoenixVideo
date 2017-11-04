defmodule Virtu.Media.Video do
  use Ecto.Schema
  import Ecto.Changeset
  alias Virtu.Media.Video

  schema "videos" do
    field :content_type, :string
    field :filename, :string
    field :path, :string
    field :title, :string
    field :video_file, :any, virtual: true

    timestamps()
  end

  def put_video_file(changeset) do
    case changeset do
    %Ecto.Changeset{valid?: true, changes: %{video_file: video_file}} ->
      path = Ecto.UUID.generate() <> Path.extname(video_file.filename)
      changeset
      |> put_change(:path, path)
      |> put_change(:filename, video_file.filename)
      |> put_change(:content_type, video_file.content_type)
    _ ->
      changeset
  end
 end
  @doc false
  def changeset(%Video{} = video, attrs) do
    video
    |> cast(attrs, [:title, :filename, :content_type, :path, :video_file])
    |> validate_required([:title, :video_file])
    |> put_video_file()
  end
end

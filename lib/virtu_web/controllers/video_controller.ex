defmodule VirtuWeb.VideoController do
  use VirtuWeb, :controller
  import Virtu.Util, only: [build_video_path: 1]
  alias Virtu.Media
  alias Virtu.Media.Video

  def index(conn, _params) do
    videos = Media.list_videos()
    render(conn, "index.html", videos: videos)
  end

  def new(conn, _params) do
    changeset = Media.change_video(%Video{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"video" => video_params}) do
    case Media.create_video(video_params) do
      {:ok, video} ->
        persist_file(video, video_params["video_file"])

        conn
        |> put_flash(:info, "Video created successfully.")
        |> redirect(to: video_path(conn, :show, video))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp persist_file(video, %{path: temp_path}) do
    video_path = build_video_path(video)
    unless File.exists?(video_path) do
      video_path |> Path.dirname() |> File.mkdir_p()
      File.copy!(temp_path, video_path)
    end
  end

  def show(conn, %{"id" => id}) do
    video = Media.get_video!(id)
    render(conn, "show.html", video: video)
  end

  def edit(conn, %{"id" => id}) do
    video = Media.get_video!(id)
    changeset = Media.change_video(video)
    render(conn, "edit.html", video: video, changeset: changeset)
  end

  def update(conn, %{"id" => id, "video" => video_params}) do
    video = Media.get_video!(id)

    case Media.update_video(video, video_params) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "Video updated successfully.")
        |> redirect(to: video_path(conn, :show, video))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", video: video, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    video = Media.get_video!(id)
    {:ok, _video} = Media.delete_video(video)

    conn
    |> put_flash(:info, "Video deleted successfully.")
    |> redirect(to: video_path(conn, :index))
  end
end

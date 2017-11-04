defmodule VirtuWeb.WatchController do
  use VirtuWeb, :controller
  import Virtu.Util
  alias Virtu.Media.Video
  alias Virtu.Repo

  def show(%{req_headers: headers} = conn, %{"id" => id}) do
    video = Repo.get!(Video, id)
    send_video(conn, headers, video)
  end
end

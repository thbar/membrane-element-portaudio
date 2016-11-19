defmodule Membrane.Element.PortAudio.SourceOptions do
  defstruct \
    device_id: nil,
    buffer_size: 256

  @type t :: %Membrane.Element.PortAudio.SourceOptions{
    device_id: String.t | nil,
    buffer_size: non_neg_integer
  }
end


defmodule Membrane.Element.PortAudio.Source do
  use Membrane.Element.Base.Source
  alias Membrane.Element.PortAudio.SourceOptions


  # Private API

  @doc false
  def handle_init(%SourceOptions{device_id: device_id, buffer_size: buffer_size}) do
    {:ok, %{
      device_id: device_id,
      buffer_size: buffer_size,
      native: nil,
    }}
  end


  @doc false
  def handle_prepare(%{device_id: device_id, buffer_size: buffer_size} = state) do
    case Membrane.Element.PortAudio.SourceNative.create(device_id, self(), buffer_size) do
      {:ok, native} ->
        {:ok, %{state | native: native}}

      {:error, reason} ->
        {:error, {:create, reason}, state}
    end
  end


  @doc false
  def handle_play(%{native: native} = state) do
    case Membrane.Element.PortAudio.SourceNative.start(native) do
      :ok ->
        {:ok, state}

      {:error, reason} ->
        {:error, {:start, reason}, state}
    end
  end


  @doc false
  def handle_stop(%{native: native} = state) do
    case Membrane.Element.PortAudio.SourceNative.stop(native) do
      :ok ->
        {:ok, state}

      {:error, reason} ->
        {:error, {:stop, reason}, state}
    end
  end


  @doc false
  def handle_other({:membrane_element_portaudio_source_packet, data}, state) do
    {:send, [
      %Membrane.Buffer{
        caps: %Membrane.Caps.Audio.Raw{channels: 2, sample_rate: 48000, format: :s16le}, # FIXME so far the format is fixed
        payload: data
      }
    ], state}
  end
end

# frozen_string_literal: true

class SpotifySongRadioButtonsInput < SimpleForm::Inputs::CollectionInput
  def input(wrapper_options)
    label_method, value_method = detect_collection_methods

    merged_input_options = merge_wrapper_options(input_html_options, wrapper_options)

    @builder.collection_radio_buttons(
      attribute_name, collection, value_method, label_method,
      input_options, merged_input_options
    ) do |b|
      build_radio_button(b)
    end
  end

  private

  def build_radio_button(b)
    b.radio_button + b.label + template.render(Song.from_spotify_track(b.object))
  end
end

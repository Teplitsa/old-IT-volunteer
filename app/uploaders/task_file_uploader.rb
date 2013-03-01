# encoding: utf-8

class TaskFileUploader < CarrierWave::Uploader::Base

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(txt doc docx rtf odt pages jpeg jpg png bmp pdf \
      xls xlsx csv ods eps ai svg cdr zip tar gz)
  end

  def white_list
    extension_white_list.map{ |ext| '.' + ext }.join(', ')
  end

end

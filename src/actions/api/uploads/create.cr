class Api::Uploads::Create < ApiAction
  post "/uploads/:file" do
    files = params.from_multipart.last
    uploaded_file = files[file]?
    unless uploaded_file.nil?
      old = Shrine::UploadedFile.new(
        id: %(/#{current_user.name}/#{file}/#{uploaded_file.filename}),
        storage_key: "store"
      )
      if old.exists?
        old.delete
      end

      result = Shrine.upload(
        io: File.new(uploaded_file.tempfile.path),
        location: %(/#{current_user.name}/#{file}/#{uploaded_file.filename}),
        storage: "store",
        metadata: {"filename" => uploaded_file.filename}
      )

      json({
        message: "Uploaded success",
        details: "The file was uploaded to `#{result.id}`"
      }, HTTP::Status::CREATED)
    else
      json({
        message: "Not found",
        details: "The file attribute `#{file}` was not found"
      }, HTTP::Status::NOT_FOUND)
    end
  end
end

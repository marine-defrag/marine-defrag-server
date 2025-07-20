# config/initializers/upload_security.rb

UPLOAD_ALLOWED_MIME_TYPES = [
  "image/png",
  "image/jpeg",
  "application/pdf",
  "application/msword",
  "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
  "application/vnd.ms-excel",  # .xls
  "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"  # .xlsx
].freeze

UPLOAD_FORBIDDEN_EXTENSIONS = %w[
  .exe .sh .bat .php .js .html .svg
].freeze

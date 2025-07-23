class SecurePasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    # password must include latin capital letters (A-Z)
    unless value =~ /[A-Z]/
      record.errors.add(attribute, "must include at least one uppercase letter")
    end

    # password must include lower case Latin letters (a-z)
    unless value =~ /[a-z]/
      record.errors.add(attribute, "must include at least one lowercase letter")
    end

    # password must include basic digits (0-9)
    unless value =~ /\d/
      record.errors.add(attribute, "must include at least one number")
    end

    # password must inlude non-alphanumeric characters (like !, $, #, -, &)
    unless value =~ /[^A-Za-z0-9]/
      record.errors.add(attribute, "must include at least one special character")
    end

    # password must not contain the whole or parts of the login name (uid/email address)
    if record.uid.present? && value.present?
      uid_parts = record.uid.downcase.split(/[@.]/).select { |part| part.length >= 3 }
      password_downcased = value.downcase

      uid_parts.each do |part|
        if password_downcased.include?(part)
          record.errors.add(attribute, "cannot contain your login name or parts of it")
          break
        end
      end
    end
  end
end

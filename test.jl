@require "." coerce

@test coerce(AbstractFloat, 1) === 1.0
@test coerce((n::AbstractFloat)->n)(1) === 1.0

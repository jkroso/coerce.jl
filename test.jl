@require "."

@test coerce(FloatingPoint, 1) === 1.0
@test coerce((n::FloatingPoint)->n)(1) === 1.0

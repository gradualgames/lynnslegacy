-- Function __drop ( this As _char_type Ptr ) As Integer
function __drop(this)
--
--
--
--   If this->d_health > Int( Rnd * 100 ) Then
  if this.d_health > math.floor(math.random() * 100) then
--     this->dropped = 1
    this.dropped = 1
--
--     this->drop->coords.x = this->coords.x + Int( Rnd * ( this->perimeter.x - 8 )  )
    this.drop.coords.x = this.coords.x + math.floor(math.random() * (this.perimeter.x - 8))
--     this->drop->coords.y = this->coords.y + Int( Rnd * ( this->perimeter.y - 8 )  )
    this.drop.coords.y = this.coords.y + math.floor(math.random() * (this.perimeter.y - 8))
--
--     Return 1
    return 1
--
--   End If
  end
--
--
--   If this->d_gold > Int( Rnd * 100 ) Then
  if this.d_gold > math.floor(math.random() * 100) then
--     this->dropped = 2
    this.dropped = 2
--
--     this->drop->coords.x = this->coords.x + Int( Rnd * ( this->perimeter.x - 8 )  )
    this.drop.coords.x = this.coords.x + math.floor(math.random() * (this.perimeter.x - 8))
--     this->drop->coords.y = this->coords.y + Int( Rnd * ( this->perimeter.y - 8 )  )
    this.drop.coords.y = this.coords.y + math.floor(math.random() * (this.perimeter.y - 8))
--
--     Return 1
    return 1
--
--   End If
  end
--
--
--   If this->d_silver > Int( Rnd * 100 ) Then
  if this.d_silver > math.floor(math.random() * 100) then
--     this->dropped = 3
    this.dropped = 3
--
--     this->drop->coords.x = this->coords.x + Int( Rnd * ( this->perimeter.x - 8 )  )
    this.drop.coords.x = this.coords.x + math.floor(math.random() * (this.perimeter.x - 8))
--     this->drop->coords.y = this->coords.y + Int( Rnd * ( this->perimeter.y - 8 )  )
    this.drop.coords.y = this.coords.y + math.floor(math.random() * (this.perimeter.y - 8))
--
--     Return 1
    return 1
--
--   End If
  end
--
--
--
--   Return 1
  return 1
--
--
--
-- End Function
end

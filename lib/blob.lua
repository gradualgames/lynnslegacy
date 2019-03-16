BlobReader = require('lib/BlobReader')

--Loads an entire file into a string and returns an object
--which acts as a binary blob for reading binary data.
function loadBlob(fileName)
    local file = io.open(fileName, 'rb')
    local blob = BlobReader(file:read('*all'))
    file:close()
    return blob
end

--Returns the offset currently pointed to in a binary blob.
function offset(blob)
    return blob._readPtr
end

--Reads a 4 byte integer from a binary blob, advancing the offset
--in the blob by 4.
function readInt(blob)
    return blob:u32()
end

--Reads a 2 byte integer from a binary blob, advancing the offset
--in the blob by 2.
function readShort(blob)
    return blob:u16()
end

--Reads a double precision floating point value from a binary blob.
function readDouble(blob)
    return blob:f64()
end

--Reads a byte from a binary blob, advancing the offset in the
--blob by 1.
function readByte(blob)
    return blob:u8()
end

--Reads a string from a binary blob, advancing the offset
--by the length of the string (the header of this string) + 2.
function readString(blob)
    return string.gsub(blob:raw(blob:u16()), "\\", "/")
end

--Reads a string from a binary blob, where we
--already know the length of string to read.
function readStringL(blob, length)
    return blob:raw(length)
end

--Repeats a given read function count times with the
--passed blob. Returns a table of the values returned
--from readF.
function readC(readF, blob, count)
    local field = {}
    for c = 1, count do
        local value = readF(blob)
        table.insert(field, value)
    end
    return field
end

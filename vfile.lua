BlobReader = require('BlobReader')

--Loads an entire file into a string and returns an object
--which acts as a virtual file for reading binary data.
function loadVFile(fileName)
    local file = io.open(fileName, 'rb')
    local blob = BlobReader(file:read('*all'))
    file:close()
    return blob
end

--Returns the offset currently pointed to in a virtual file.
function offset(vFile)
    return vFile._readPtr
end

--Reads a 4 byte integer from a virtual file, advancing the offset
--in the vFile by 4.
function readInt(vFile)
    return vFile:u32()
end

--Reads a 2 byte integer from a virtual file, advancing the offset
--in the vFile by 2.
function readShort(vFile)
    return vFile:u16()
end

--Reads a byte from a virtual file, advancing the offset in the
--vFile by 1.
function readByte(vFile)
    return vFile:u8()
end

--Reads a string from a virtual file, advancing the offset
--by the length of the string (the header of this string) + 2.
function readString(vFile)
    return vFile:raw(vFile:u16())
end

--Reads a string from a virtual file, where we
--already know the length of string to read.
function readStringL(vFile, length)
    return vFile:raw(length)
end

--Repeats a given read function count times with the
--passed vFile. Returns a table of the values returned
--from readF.
function readC(readF, vFile, count)
    local field = {}
    for c = 1, count do
        local value = readF(vFile)
        table.insert(field, value)
    end
    return field
end

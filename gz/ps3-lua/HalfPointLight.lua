HalfPointLight = {

-- CreateTool‚Åì‚ç‚ê‚½ˆÊ’u‚ğPlane‚ÌPosition‚Ö
CreateToolCommand = function( position )
    local   data, body

    data, body = Command.CreateData( "HalfPointLight" )
    data.halfPlanePosition = position

    return  data, body
end,

}
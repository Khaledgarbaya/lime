package lime.graphics.opengl; #if (!js || !html5)


class GLTexture extends GLObject {
	
	
	private override function getType ():String {
		
		return "Texture";
		
	}
    
    
}


#else
typedef GLTexture = js.html.webgl.Texture;
#end
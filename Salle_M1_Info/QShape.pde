public class QShape {
	float x, y, z;
	PShape shape;
	QShape(float x, float y, float z) {
		this.x = x;
		this.y = y;
		this.z = z;
		shape = null;
	}	

	void rotateX(float angle) {
		if(shape == null) return;
		shape.rotateX(angle);
	}

	void rotateY(float angle) {
		if(shape == null) return;
		shape.rotateY(angle);
	}

	void rotateZ(float angle) {
		if(shape == null) return;
		shape.rotateZ(angle);
	}

	void translate(float x, float y, float z) {
		shape.translate(x, y, z);
	}

	void drawShape() {
		if (shape == null) return; // Vérification de nullité
    	shape(shape);
	}

	public PShape getShape() {
		return shape;
	}
}

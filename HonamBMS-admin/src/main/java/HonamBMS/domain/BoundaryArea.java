package honambms.domain;

import lombok.Setter;

import java.io.Serializable;

import lombok.Getter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoundaryArea implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 8516197335051704582L;
	private String longitude;
	private String latitude;
	private String field;
	
	private String point;
}

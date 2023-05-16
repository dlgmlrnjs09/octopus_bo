## 1. 공통 명명 규칙	
- 1-1. 대소문자가 구분되며 길이에 제한이 없다.	
- 1-2. 예약어를 사용해서는 안 된다	
- 1-3. 숫자로 시작해서는 안 된다.	
- 1-4. 특수문자는 '_' 와 '$'만을 허용한다.	
- 1-5. 파스칼 표기법 (PascalCase)과 카멜 표기법(camelCase)를 사용한다.	    
        PascalCase : 모든 단어에서 첫 번째 문자는 대문자이며 나머지는 소문자이다.	    
        camelCase : 최초에 사용된 단어를 제외한 첫 번째 문자가 대문자이며 나머지는 소문자이다.	
	
## 2. 패키지(Package) 명명 규칙	
**패키지명은 표준 패턴을 따라야 한다.**	     
Ex) [com].[Company].[Project].[TopPackage].[LowerPackage]	
	
**패키지명은 가급적 한 단어의 명사를 사용한다**    	
Ex) 좋은 예 : com.weaver.octopus.member.object 	
Ex)  나쁜 예 : octopus.memberObject    
	
## 3. 클래스(Class) 명명 규칙	
- 3-1. 클래스명에는 파스칼을 사용한다.  	
        Ex) public class HelloWorld {}	
	
- 3-2. 인터페이스에는 특별한 접두사나 접미사를 사용하지 않고 파스칼을 사용한다.	    
        Ex) public interface Animal {}	
	
- 3-3. 인터페이스를 구현한 클래스에는 특별한 접두사나 접미사를 사용하지 않고 파스칼을 사용한다.	    
        Ex) public class Tiger implements animal{}	
	
- 3-4. 추상 클래스에는 특별한 접두사 접미사를 사용하지 않고 파스칼을 사용한다. 	
        Ex) public abstract class Animal {}	
	
- 3-5. 메소드명에는 파스칼 표기법을 사용한다.	    
        Ex) public void SendMessage(String message) {}	
	
- 3-6. 속성에 접근하는 메소드명의 접두사는 'get','set'을 사용한다.	    
        Ex) public void setDisplayName	
	
- 3-7. 데이터를 조회하는 메소드명의 접두사는 select를 사용한다.	    
        Ex) public void selectData(String data){}	
	
- 3-8. 데이터를 입력하는 메소드명의 접두사는 insert를 사용한다.    	
        Ex) public void insertData(HashMap data){}	
	
- 3-9. 데이터를 변경하는 메소드명의 접두사는 update를 사용한다.	    
        Ex) public void updateData(HashMap data){}	
	
- 3-10. 데이터를 삭제하는 메소드명의 접두사는 delete를 사용한다.	    
         Ex) public void deleteData(String data){}	
	
- 3-11. 데이터를 초기화 하는 메소드명의 접두사는 init을 사용한다.	    
        Ex) public void initData(String data){}	
	
- 3-12. 반환값의 타입이 boolean인 메소드는 접두사로 is를 사용한다.	    
        Ex) public void isData(String Data){}	
	
- 3-13. 데이터를 불러오는 메소드명의 접두사는 load를 사용한다.	    
        Ex) public void loadData(){}	
	
- 3-14. 데이터가 있는지 확인하는 메소드명의 접두사는 has를 사용한다.	    
        Ex) public void hasData(){}	
	
- 3-15. 보다 지능적인 set이 요구될때 사용하는 메소드명의 접두사는 register를 사용한다.	    
        Ex) public void registerAccount(){}	
	
- 3-16. 새로운 객체를 만든뒤 해당 객체를 리턴해주는 메소드명의 접두사는 create를 사용한다.	    
        Ex) public void createAccount(){}	
	
- 3-17. 해당 객체를 다른 형태의 객체로 변환해주는 메소드명의 접두사는 to를 사용한다.	    
        Ex) public void toString(){}	
	
- 3-18. 해당 객체가 복수인지 단일인지 구분하는 메서드명의 접미사는 s를 사용한다.	    
        Ex) public void getMembers(){}	
	
- 3-19. B를 기준으로 A를 하겠다는 메소드명의 전치사는 By를 사용한다.	    
        Ex) public void getUserByName(String name){}	
	
- 3-20. 반환값의 타입이 boolean인 메소드는 접두사로 is를 사용한다.	    
        Ex) public void isData(String Data){}	
	
- 3-21. 데이터를 불러오는 메소드명의 접두사는 load를 사용한다.	    
        Ex) public void loadData(){}	
	
- 3-22. 데이터가 있는지 확인하는 메소드명의 접두사는 has를 사용한다.	    
        Ex) public void hasData(){}	
	
- 3-23. 보다 지능적인 set이 요구될때 사용하는 메소드명의 접두사는 register를 사용한다.	    
         Ex) public void registerAccount(){}	
	
- 3-24. 새로운 객체를 만든뒤 해당 객체를 리턴해주는 메소드명의 접두사는 create를 사용한다.	    
        Ex) public void createAccount(){}	
	
- 3-25. 해당 객체를 다른 형태의 객체로 변환해주는 메소드명의 접두사는 to를 사용한다.	    
        Ex) public void toString(){}	
	
- 3-26. 해당 객체가 복수인지 단일인지 구분하는 메서드명의 접미사는 s를 사용한다.	    
        Ex) public void getMembers(){}	
	
- 3-27. B를 기준으로 A를 하겠다는 메소드명의 전치사는 By를 사용한다.	    
        Ex) public void getUserByName(String name){}	

## 4. 컨트롤러 (Controller) 명명 규칙
- 1-1. 매핑 경로는 케밥 표기법(kebab-case)를 사용한다.
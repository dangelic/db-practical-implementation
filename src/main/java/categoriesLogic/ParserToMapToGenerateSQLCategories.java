package categoriesLogic;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

public class ParserToMapToGenerateSQLCategories {
    private static int categoryIdCounter = 1;
    private DocumentBuilder documentBuilder;

    public ParserToMapToGenerateSQLCategories() {
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            factory.setNamespaceAware(true);
            factory.setFeature("http://xml.org/sax/features/namespaces", true);
            factory.setFeature("http://xml.org/sax/features/validation", false);
            factory.setXIncludeAware(false);

            documentBuilder = factory.newDocumentBuilder();
            documentBuilder.setErrorHandler(null); // Disable error handler
        } catch (ParserConfigurationException e) {
            e.printStackTrace();
        }
    }

    public List<String> generateSQLCategoryEntity(String xmlFilePath) {
        List<String> categorySQLStrings = new ArrayList<>();
        Set<String> uniqueCategoryNames = new HashSet<>();

        try {
            File xmlFile = new File(xmlFilePath);
            Charset latin1Charset = Charset.forName("UTF-8");
            FileInputStream inputStream = new FileInputStream(xmlFile);
            InputStreamReader reader = new InputStreamReader(inputStream, latin1Charset);
            InputSource inputSource = new InputSource(reader);

            Document document = documentBuilder.parse(inputSource);
            document.getDocumentElement().normalize();

            Element rootElement = document.getDocumentElement();
            NodeList categories = rootElement.getElementsByTagName("category");

            for (int i = 0; i < categories.getLength(); i++) {
                Element category = (Element) categories.item(i);
                String categoryName = category.getFirstChild().getNodeValue().trim();

                if (uniqueCategoryNames.add(categoryName)) {
                    String categoryId = Integer.toString(categoryIdCounter++);
                    String parentId = generateParentId(category);

                    String categorySQL = generateCategorySQL(categoryId, categoryName, parentId);
                    categorySQLStrings.add(categorySQL);
                }
            }
        } catch (SAXException | IOException e) {
            e.printStackTrace();
        }

        return categorySQLStrings;
    }


    public List<String> generateSQLJunction(String xmlFilePath) {
        List<String> junctionSQLStrings = new ArrayList<>();
        Set<String> uniqueMappings = new HashSet<>();

        try {
            File xmlFile = new File(xmlFilePath);
            Charset latin1Charset = Charset.forName("UTF-8");
            FileInputStream inputStream = new FileInputStream(xmlFile);
            InputStreamReader reader = new InputStreamReader(inputStream, latin1Charset);
            InputSource inputSource = new InputSource(reader);

            Document document = documentBuilder.parse(inputSource);
            document.getDocumentElement().normalize();

            Element rootElement = document.getDocumentElement();
            NodeList categories = rootElement.getElementsByTagName("category");

            for (int i = 0; i < categories.getLength(); i++) {
                Element category = (Element) categories.item(i);
                String categoryId = Integer.toString(i + 1);

                NodeList items = category.getElementsByTagName("item");
                for (int j = 0; j < items.getLength(); j++) {
                    Element item = (Element) items.item(j);
                    String productId = item.getTextContent().trim();

                    String mappingSQL = generateMappingSQL(categoryId, productId);
                    if (uniqueMappings.add(mappingSQL)) {
                        // Only add the mapping if it is unique
                        junctionSQLStrings.add(mappingSQL);
                    }
                }
            }
        } catch (SAXException | IOException e) {
            e.printStackTrace();
        }

        return junctionSQLStrings;
    }

    private String generateParentId(Element category) {
        // Check if the category has a parent category
        Node parentNode = category.getParentNode();
        if (parentNode.getNodeType() == Node.ELEMENT_NODE && "category".equals(parentNode.getNodeName())) {
            Element parentCategory = (Element) parentNode;
            String parentId = parentCategory.getAttribute("id");
            if (parentId == null || parentId.isEmpty()) {
                // Generate a parent ID if it doesn't exist
                parentId = Integer.toString(categoryIdCounter++);
                parentCategory.setAttribute("id", parentId);
            }
            return parentId;
        }
        return null; // No parent category
    }

    private String generateCategorySQL(String categoryId, String categoryName, String parentId) {
        StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder.append("INSERT INTO categories (name, category_id, parent_category_id) VALUES (");
        sqlBuilder.append(getSqlValue(categoryName)).append(", ");
        sqlBuilder.append(getSqlValue(categoryId)).append(", ");
        sqlBuilder.append(getSqlValue(parentId)).append(");");
        return sqlBuilder.toString();
    }

    private String generateMappingSQL(String categoryId, String productId) {
        StringBuilder sqlBuilder = new StringBuilder();
        sqlBuilder.append("INSERT INTO junction_products_categories (categories_category_id, products_asin) VALUES (");
        sqlBuilder.append(getSqlValue(categoryId)).append(", ");
        sqlBuilder.append(getSqlValue(productId)).append(");");
        return sqlBuilder.toString();
    }

    private String getSqlValue(String value) {
        if (value == null) {
            return "NULL";
        }
        return "'" + escapeSqlString(value) + "'";
    }


    private String escapeSqlString(String value) {
        return value.replace("'", "''").replace("\"", "\"\"");
    }
}

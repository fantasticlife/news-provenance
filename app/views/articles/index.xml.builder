xml.instruct! :xml, :version => '1.0'

xml.gexf( 'xmlns' => 'http://www.gexf.net/1.2draft', 'xmlns:xsi' => 'http://www.w3.org/2001/XMLSchema-instance', 'xsi:schemaLocation' => 'http://www.gexf.net/1.2draft http://www.gexf.net/1.2draft/gexf.xsd', :version => '1.2' ) do
  xml.graph( 'mode' => 'static', 'defaultedgetype' => 'directed' ) do
    xml.nodes do
      xml << render( :partial => 'node', :collection => @articles )
    end
    xml.edges do
      xml << render( :partial => 'edge', :collection => @article_similarities )
    end
  end
end
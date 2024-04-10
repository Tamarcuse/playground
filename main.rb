class TreeNode
  attr_accessor :name, :children

  def initialize(name, children = [])
    @name = name
    @children = children
  end

  def parent?
    !children.empty?
  end

end

def print_no_parent_children(node)
  if !node.parent?
    puts "#{node.name}: #{0}"
    return 1
  else
    n = node.children.map{ |child| print_no_parent_children(child) }.reduce(0) { |res, el| res + el }
    puts "#{node.name}: #{n}"
    return n
  end
end

# 1
#         A(2)
#      B(1)   C(0)
#    D(0)

#d = TreeNode.new('D')
#c = TreeNode.new('C')
#b = TreeNode.new('B', [d])
#a = TreeNode.new('A', [b,c])
#print_no_parent_children a

# 2
#              A(4)
#       B(2)    C(0)    D(1)
#    E(1) F(0)             H(0)
#   I(0)

i = TreeNode.new('I')
h = TreeNode.new('H')
f = TreeNode.new('F')
e = TreeNode.new('E', [i])
d = TreeNode.new('D', [h])
c = TreeNode.new('C')
b = TreeNode.new('B', [e,f])
a = TreeNode.new('A', [b,c,d])
# print_no_parent_children a

class TreeNodeIterator
  attr_accessor :nexts

  def initialize(root)
    @nexts = [root]
  end

  def has_next?
    !nexts.empty?
  end

  def next
    node = nexts.shift
    @nexts += node.children
    node
  end
end

i = TreeNodeIterator.new(a)

while i.has_next?
  puts i.next.name
end

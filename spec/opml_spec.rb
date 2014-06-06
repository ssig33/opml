require 'spec_helper'
require 'opml'

shared_examples "a sample OPML file" do

  it "should have the owner of the document" do
    expect(@opml.owner_name).to eq("Dave Winer")
  end

  it "should have the email address of the owner of the document" do
    expect(@opml.owner_email).to eq("dave@userland.com")
  end

end

shared_examples "an empty OPML file" do

  it "should have no title" do
    expect(@opml.title).to be_nil
  end

  it "should have no outlines" do
    expect(@opml.outlines.size).to eq(0)
  end

end


describe Opml, "playlist" do

  before do
    text = File.read(File.dirname(__FILE__) + "/files/playlist.opml")
    @opml = Opml.new(text)
  end

  it_should_behave_like "a sample OPML file"

  it "should have a title of the document" do
    expect(@opml.title).to eq("playlist.xml")
  end

  it "should have a date-time, indicating when the document was created" do
    expect(@opml.date_created).to eq(Time.parse("Thu, 27 Jul 2000 03:24:18 GMT"))
  end

  it "should have a date-time, indicating when the document was last modified" do
    expect(@opml.date_modified).to eq(Time.parse("Fri, 15 Sep 2000 09:01:23 GMT"))
  end

  it "should have outlines" do
    expect(@opml.outlines.size).to eq(3)
    expect(@opml.outlines[0].outlines.size).to eq(1)
    expect(@opml.outlines[1].outlines.size).to eq(13)
    expect(@opml.outlines[2].outlines.size).to eq(7)
  end

  it "should return flattened outlines" do
    expect(@opml.flatten.size).to eq(24)
  end

end

describe Opml, "presentation" do

  before do
    text = File.read(File.dirname(__FILE__) + "/files/presentation.opml")
    @opml = Opml.new(text)
  end

  it_should_behave_like "a sample OPML file"

  it "should have a title of the document" do
    expect(@opml.title).to eq("presentation.xml")
  end

  it "should have a date-time, indicating when the document was created" do
    expect(@opml.date_created).to eq(Time.parse("Thu, 27 Jul 2000 01:35:52 GMT"))
  end

  it "should have a date-time, indicating when the document was last modified" do
    expect(@opml.date_modified).to eq(Time.parse("Fri, 15 Sep 2000 09:05:37 GMT"))
  end

  it "should have outlines" do
    expect(@opml.outlines.size).to eq(17)
    expect(@opml.outlines[0].outlines.size).to eq(2)
    expect(@opml.outlines[1].outlines.size).to eq(5)
    expect(@opml.outlines[2].outlines.size).to eq(4)
  end

  it "should return flattened outlines" do
    expect(@opml.flatten.size).to eq(91)
  end

end

describe Opml, "specification" do

  before do
    text = File.read(File.dirname(__FILE__) + "/files/specification.opml")
    @opml = Opml.new(text)
  end

  it_should_behave_like "a sample OPML file"

  it "should have a title of the document" do
    expect(@opml.title).to eq("specification.xml")
  end

  it "should have a date-time, indicating when the document was created" do
    expect(@opml.date_created).to eq(Time.parse("Thu, 27 Jul 2000 01:20:06 GMT"))
  end

  it "should have a date-time, indicating when the document was last modified" do
    expect(@opml.date_modified).to eq(Time.parse("Fri, 15 Sep 2000 09:04:03 GMT"))
  end

  it "should have outlines" do
    expect(@opml.outlines.size).to eq(4)
    expect(@opml.outlines[0].outlines.size).to eq(4)
    expect(@opml.outlines[1].outlines.size).to eq(4)
    expect(@opml.outlines[2].outlines.size).to eq(4)
  end

  it "should return flattened outlines" do
    expect(@opml.flatten.size).to eq(17)
  end

end

describe Opml, "empty body" do

  before do
    @opml = Opml.new("<opml><body></body></opml>")
  end

  it_should_behave_like "an empty OPML file"

end

describe Opml, "empty outline" do

  before do
    @opml = Opml.new("<opml></opml>")
  end

  it_should_behave_like "an empty OPML file"

end

describe Opml, "empty file" do

  before do
    @opml = Opml.new("")
  end

  it_should_behave_like "an empty OPML file"

end

describe Opml, "incorrect date" do

  before do
    @opml = Opml.new("<opml><head><dateCreated>1372185524793</dateCreated></head><body></body></opml>")
  end

  it_should_behave_like "an empty OPML file"

end

describe Opml::Outline, "in playlist" do

  before do
    text = File.read(File.dirname(__FILE__) + "/files/playlist.opml")
    @outline = Opml.new(text).outlines[1]
  end

  it "should return all attributes" do
    expect(@outline.attributes).to eq({"text" => "The Last Napster Sunday?"})
  end

  it "should return text attribute" do
    expect(@outline.text).to eq("The Last Napster Sunday?")
  end

  it "should respond to text attribute" do
    expect(@outline.respond_to?(:text)).to eq(true)
  end

  it "should return text when coerce into a string" do
    expect(@outline.to_s).to eq("The Last Napster Sunday?")
  end

  it "should return flattened child outlines" do
    expect(@outline.flatten.map(&:to_s)).to eq([
      "The Last Napster Sunday?", 
      "Heart of Glass.mp3", 
      "Manic Monday.mp3", 
      "Everybody Have Fun Tonight.mp3", 
      "She Blinded Me With Science.mp3", 
      "Rivers of Babylon   (HTC).mp3", 
      "The Tide Is High.mp3", 
      "Back to the Island.mp3", 
      "Lucky Man.mp3", 
      "Up on Cripple Creek.mp3", 
      "Crackerbox Palace.mp3", 
      "Taxi.Mp3", 
      "Thick As A Brick.mp3", 
      "Riding With the King.mp3"
    ])
  end

end

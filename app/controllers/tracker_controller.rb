require 'pivotal-tracker'
require 'action_view'
require 'time'
include ActionView::Helpers::DateHelper

class TrackerController < ApplicationController
  before_filter :set_token

  TOKEN = '08539f090ea545493b3922beaa268671'
  PROJECT_ID = 120385

  # retrive tracker activity
  def index
    project = PivotalTracker::Project.find(PROJECT_ID)
    data = []
    activity = PivotalTracker::Activity.all
    activity.each do |item|
      act = {}
      full_story = project.stories.find(item.stories.first.id) if item.stories.first

      act[:story_name] = full_story.name
      act[:description] = item.description
      act[:story_type] = full_story.story_type if item.stories.first
      t = Time.parse(item.occurred_at.to_s)
      act[:when] = "#{distance_of_time_in_words(Time.now, t)} ago"
      data << act
    end # activity.each
    
    render :text => data.to_json
  end

  def set_token
    PivotalTracker::Client.token = TOKEN
  end

end

#!/usr/bin/ruby

module SPOJ

  class Hotline
    @@subject = "\\w+"
    @@modifier = "don't |doesn't "
    @@predicate = "\\w+s?"
    @@object = " .*"
    @@auxiliar = "do|does"

    @@question1 = /(#{@@auxiliar}) (#{@@subject}) (#{@@predicate})(#{@@object})?\?/
    @@question2 = /who (#{@@predicate})(#{@@object})?\?/
    @@question3 = /what (#{@@auxiliar}) (#{@@subject}) do\?/

    @@question = /(#{@@question1})|(#{@@question2})|(#{@@question3})/
    @@statement = /(#{@@subject}) (#{@@modifier})?(#{@@predicate})(#{@@object})?\./

    @@special_subjects = {"I"=>"you", "you"=>"I"}
    @@yes_no = {false => "no", true => "yes"}

    attr_accessor :subjects, :predicates, :on_call, :bye_text, :contradiction

    def initialize
      self.on_call = true
      self.subjects = {}
      self.predicates = {}
      self.contradiction = false
    end

    def respond_to(sentence)
      if sentence[-1] == '!'
        self.bye_text = sentence
        self.on_call = false
        return
      end

      info = sentence.match @@statement
      if info
        store_information info
      else
        puts sentence
        question = sentence.match @@question
        answer question
        puts
      end
    end

    def store_information(info)
      return if contradiction? # stop storing if contradiction found

      subject = info[1]
      status = ((info[2] == nil) and (subject != 'nobody'))
      predicate = info[3].chomp('s')
      object = info[4]
      subject = "all" if subject == 'nobody' or subject == 'everybody'
      full_predicate = "#{predicate}#{object}"

      # search for contradictions
      if self.predicates[full_predicate]
        if subject == "all"
          values = self.predicates[full_predicate].values.uniq
          self.contradiction = true if values.size == 2 or values[0] != status
        else
          previous_subject = self.subjects["all"] || self.subjects[subject] || {}
          previous_status = previous_subject[full_predicate]
          self.contradiction = true if previous_status != nil and previous_status != status
        end

        return if contradiction? # just ignore everything else
      end

      # initialize 
      self.subjects[subject] ||= {}
      self.predicates[full_predicate] ||= {}

      self.subjects[subject].store(full_predicate, status)
      self.predicates[full_predicate].store(subject, status)
    end

    def answer(question)
      if contradiction?
        puts "I am abroad."
        return
      end
      if question[1]
        puts answer_other question
      elsif question[6]
        puts answer_who question
      else
        puts answer_what question
      end
    end

    def answer_who(question)
      subject = nil
      predicate = question[7]
      object = question[8]
      full_predicate = "#{predicate.chomp('s')}#{object}"

      activity = self.predicates[full_predicate] || {}
      if activity["all"] == true
        subject = "everybody"
      elsif activity["all"] == false
        subject = "nobody"
      else
        subjects = activity.map { |k,v| k if v }.compact
        return "I don't know." if subjects.empty?

        # handle multiple subjects
        subjects = subjects.map { |sub| @@special_subjects[sub] || sub }
        if subjects.size > 1
          subjects[-1] = "#{subjects[-2]} and #{subjects.pop}"
          predicate.chomp!('s')
        end
        subject = subjects.join(", ")
        predicate.chomp!('s') if subject =~ /I|you/
      end

      [subject, predicate + object.to_s].compact.join(' ') + "."
    end

    def answer_what(question)
      subject = question[11]
      plural = true if subject =~ /I|you/
      auxiliar = plural ? "don't " : "doesn't "
      current_predicates = self.predicates.map do |pred, subj|
        unless subj[subject].nil? and subj["all"].nil?
          status = auxiliar unless (subj["all"] || subj[subject])
          pred = pred.sub(/$| /, 's ').strip if !plural and status.nil?
          "#{status}#{pred}"
        end
      end.compact

      return "I don't know." if current_predicates.empty?
      current_predicates[-1] = "and " + current_predicates[-1] if current_predicates.size > 1
      
      "#{@@special_subjects[subject] || subject} #{current_predicates.join(', ')}."
    end

    def answer_other(question)
      subject = question[3]
      plural = true if subject =~ /I|you/
      full_predicate = "#{question[4].chomp('s')}#{question[5]}"

      activity = self.predicates[full_predicate] || {}
      return "maybe." if activity["all"].nil? and activity[subject].nil?

      status = (activity["all"] || activity[subject] || false)
      auxiliar = (plural ? "don't " : "doesn't ") unless status
      predicate = question[4]
      predicate += 's' unless plural or auxiliar
      object = question[5]

      "#{@@yes_no[status]}, #{@@special_subjects[subject] || subject} #{auxiliar}#{predicate}#{object}."
    end

    def contradiction?
      self.contradiction
    end

    def on_call?
      self.on_call
    end

    def hang_up
      puts self.bye_text
      puts
    end

  end

end


if __FILE__ == $0
  tests = gets.to_i # dialogs => unknown number

  tests.times do |i|
    puts "Dialogue ##{i+1}:"
    hotline = SPOJ::Hotline.new
    while hotline.on_call?
      sentence = gets.chomp
      hotline.respond_to sentence
    end
    hotline.hang_up
  end

end


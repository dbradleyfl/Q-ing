describe ("createDuration", function() {
	xit("should return a duration object", function() {
		expect(createDuration()).toBeDefined();
	});
	xit("should return duration with time 0 when created", function() {
		var duration = createDuration();
		expect(duration.duration).toEqual(0);
	});
})